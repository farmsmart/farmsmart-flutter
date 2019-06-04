import os
import slack
import argparse


# Declare command-line flags.
argparser = argparse.ArgumentParser()
argparser.add_argument('slack_api_token', help='The slack API token for authentication.')
argparser.add_argument('message', help='The message to send.')

args = argparser.parse_args()
slack_api_token = args.slack_api_token
message = args.message

client = slack.WebClient(token=slack_api_token)
response = client.chat_postMessage(
    channel='#farmsmart-build',
    text=message)
