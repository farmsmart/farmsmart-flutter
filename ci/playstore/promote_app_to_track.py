#!/usr/bin/python
from google.oauth2 import service_account
import googleapiclient.discovery
import argparse
import re


# Declare command-line flags.
argparser = argparse.ArgumentParser()
argparser.add_argument('package_name', help='The package name. Example: com.android.sample')
argparser.add_argument('track', help='The track to update.')
argparser.add_argument('version_name', help='The version name for the release.')
argparser.add_argument('version_code', help='The version_code to promote.')
argparser.add_argument('release_notes_file', help='The file which contains the release notes.')
argparser.add_argument('app_files', help='The paths to the aab\'s to upload seperated by a comma.')

args = argparser.parse_args()
package_name = args.package_name
track = args.track
version_name = args.version_name
version_code = args.version_code
release_notes_file = args.release_notes_file
app_files = args.app_files.split(",")

# Authorise the publishing API
service_account_file_path = "secrets/google-play-service-account.json"
SCOPES = ['https://www.googleapis.com/auth/androidpublisher']

credentials = service_account.Credentials.from_service_account_file(service_account_file_path, scopes=SCOPES)

androidPublisher = googleapiclient.discovery.build('androidpublisher', 'v3', credentials=credentials)

# API calls
edit_request = androidPublisher.edits().insert(body={}, packageName=package_name)
edit_response = edit_request.execute()
edit_id = edit_response['id']

for app_file in app_files:
    app_upload_request = androidPublisher.edits().bundles().upload(
        editId=edit_id,
        packageName=package_name,
        media_body=app_file,
        media_mime_type='application/octet-stream')
    app_upload_response = app_upload_request.execute()

tracks_req = androidPublisher.edits().tracks().get(packageName=package_name, editId=edit_id, track=track)
tracks_res = tracks_req.execute()

new_release = tracks_res['releases'][0]

new_release_notes = []
new_release_codes = []
new_release_codes.append(version_code)

release_notes = open(release_notes_file,"r+").read()
release_notes_match = re.findall("<([a-z]{2}-?([A-Z]{2,3})?)>\n(.*?)<\/([a-z]{2}-?([A-Z]{2,3})?)>", release_notes, re.S)

for language in release_notes_match:
    language_dict = {}
    language_dict['language'] = language[0]
    language_dict['text'] = language[2]
    new_release_notes.append(language_dict)

new_release['name'] = version_name
new_release['versionCodes'] = new_release_codes
new_release['releaseNotes'] = new_release_notes
new_release['status'] = 'completed'

release_body = tracks_res
release_body['releases'] = [new_release]

track_update_req = androidPublisher.edits().tracks().update(packageName=package_name, editId=edit_id, track=track, body=release_body)
track_update_res = track_update_req.execute()

validate_request = androidPublisher.edits().validate(packageName=package_name, editId=edit_id)
validate_response = validate_request.execute()

commit_request = androidPublisher.edits().commit(packageName=package_name, editId=edit_id)
commit_response = commit_request.execute()
