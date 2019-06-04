#!/usr/bin/python
from google.oauth2 import service_account
import googleapiclient.discovery
import argparse
import json


# Declare command-line flags.
argparser = argparse.ArgumentParser()
argparser.add_argument('package_name', help='The package name. Example: com.android.sample')
argparser.add_argument('version_name', help='The version name for the release.')
argparser.add_argument('apk_file', help='The apk to upload.')

args = argparser.parse_args()
package_name = args.package_name
version_name = args.version_name
apk_file = args.apk_file

# Authorise the publishing API
service_account_file_path = "secrets/google-play-service-account.json"
SCOPES = ['https://www.googleapis.com/auth/androidpublisher']

credentials = service_account.Credentials.from_service_account_file(service_account_file_path, scopes=SCOPES)

androidPublisher = googleapiclient.discovery.build('androidpublisher', 'v3', credentials=credentials)

# API calls

apk_upload_request = androidPublisher.internalappsharingartifacts().uploadapk(packageName=package_name, media_body=apk_file, media_mime_type=None)
apk_upload_response = apk_upload_request.execute()
apk = {
        "version_name": version_name,
        "download_url": apk_upload_response['downloadUrl'],
        "certificate_fingerprint": apk_upload_response['certificateFingerprint']
    }

print(json.dumps(apk))
