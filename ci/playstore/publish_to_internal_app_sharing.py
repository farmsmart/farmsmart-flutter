#!/usr/bin/python
from google.oauth2 import service_account
import googleapiclient.discovery
from googleapiclient.errors import HttpError
import argparse
import json
import time


# Declare command-line flags.
argparser = argparse.ArgumentParser()
argparser.add_argument('package_name', help='The package name. Example: com.android.sample')
argparser.add_argument('version_name', help='The version name for the release.')
argparser.add_argument('app_file', help='The app to upload.')

args = argparser.parse_args()
package_name = args.package_name
version_name = args.version_name
app_file = args.app_file

# Authorise the publishing API
service_account_file_path = "secrets/google-play-service-account.json"
SCOPES = ['https://www.googleapis.com/auth/androidpublisher']

credentials = service_account.Credentials.from_service_account_file(service_account_file_path, scopes=SCOPES)

androidPublisher = googleapiclient.discovery.build('androidpublisher', 'v3', credentials=credentials)

# API calls

def upload_app(package_name, app_file):

    app_upload_request = androidPublisher.internalappsharingartifacts().uploadbundle(packageName=package_name, media_body=app_file, media_mime_type='application/octet-stream')
    app_upload_response = app_upload_request.execute()
    app = {
        "version_name": version_name,
        "download_url": app_upload_response['downloadUrl'],
        "certificate_fingerprint": app_upload_response['certificateFingerprint']
    }
    return app

def upload_app_with_retry(package_name, app_file, retry_count):

    for i in range(0, retry_count - 2):
        while True:
            try:
                app = upload_app(package_name, app_file)
                return app
            except HttpError as err:
                if err.resp.status in [403, 500, 503]:
                    time.sleep(5)
                else: raise
                continue
            break
        app = upload_app(package_name, app_file)
        return app

app = upload_app_with_retry(package_name, app_file, 3)
print(json.dumps(app))
