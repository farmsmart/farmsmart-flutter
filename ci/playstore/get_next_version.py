#!/usr/bin/python
from google.oauth2 import service_account
import googleapiclient.discovery
import argparse
import json
from versionInfo import VersionInfo

# Declare command-line flags.
argparser = argparse.ArgumentParser()
argparser.add_argument('package_name', help='The package name. Example: com.android.sample')
argparser.add_argument('version_name', help='The version in the format xx.yy.zzz eg 1.2.1')
argparser.add_argument('track', help='The track name')

args = argparser.parse_args()
package_name = args.package_name
version_name = args.version_name
track = args.track

# Authorise the publishing API
service_account_file_path = "secrets/google-play-service-account.json"
SCOPES = ['https://www.googleapis.com/auth/androidpublisher']
credentials = service_account.Credentials.from_service_account_file(service_account_file_path, scopes=SCOPES)
androidPublisher = googleapiclient.discovery.build('androidpublisher', 'v3', credentials=credentials)

# API calls
edit_request = androidPublisher.edits().insert(body={}, packageName=package_name)
edit_response = edit_request.execute()
edit_id = edit_response['id']

tracks_req = androidPublisher.edits().tracks().get(packageName=package_name, editId=edit_id, track=track)
tracks_res = tracks_req.execute()

releases = tracks_res['releases']
current_release = next(r for r in releases if r['status'] == 'completed')
current_version_code = max(current_release['versionCodes'])

# Determine next version
current_version = VersionInfo.from_version_code(current_version_code)
next_version = VersionInfo.from_version_name(version_name)
next_version.build = VersionInfo.get_next_build(current_version, next_version)
print(next_version.as_json())
