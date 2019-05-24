export TRACK=alpha
export VERSION=$(echo $CIRCLE_BRANCH | sed 's/.*\/v\(.*\)/\1/')
export TRACK_URL="https://play.google.com/apps/testing/co.farmsmart.app"
