#!/usr/bin/python
from google.oauth2 import service_account
import googleapiclient.discovery
import argparse
import json


# Declare command-line flags.
argparser = argparse.ArgumentParser()
argparser.add_argument('package_name', help='The package name. Example: com.android.sample')
argparser.add_argument('apk_paths', help='The apks to upload seperated by a comma. Example: ./path-to-apk1,./path-to-apk2')

args = argparser.parse_args()
package_name = args.package_name
apk_paths = args.apk_paths

apks = apk_paths.split(",")

# Authorise the publishing API
service_account_file_path = "secrets/google-play-service-account.json"
SCOPES = ['https://www.googleapis.com/auth/androidpublisher']

credentials = service_account.Credentials.from_service_account_file(service_account_file_path, scopes=SCOPES)

androidPublisher = googleapiclient.discovery.build('androidpublisher', 'v3', credentials=credentials)

# API calls

apks_info = []

for apk in apks:
    apk_upload_request = androidPublisher.internalappsharingartifacts().uploadapk(packageName=package_name, media_body=apk, media_mime_type=None)
    apk_upload_response = apk_upload_request.execute()
    apk = {
            "version_name": apk,
            "download_url": apk_upload_response['download_url']
        }
    apks_info.append(apk)

print(json.dumps(apks_info))
