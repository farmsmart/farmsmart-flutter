import os
import slack
import argparse


# Declare command-line flags.
argparser = argparse.ArgumentParser()
argparser.add_argument('slack_api_token', help='The slack API token for authentication.')
argparser.add_argument('track', help='The playstore track.')
argparser.add_argument('track_url', help='The playstore URL for the app.')
argparser.add_argument('version', help='The version of the apk.')

args = argparser.parse_args()
slack_api_token = args.slack_api_token
track_url = args.track_url
version = args.version
track = args.track

client = slack.WebClient(token=slack_api_token)
response = client.chat_postMessage(
    channel='#farmsmart-build',
    text=f'{track.capitalize()} track - Release {version} is now available! {track_url}')
