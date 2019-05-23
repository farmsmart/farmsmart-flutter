export TRACK=alpha
export VERSION=$(echo $CIRCLE_BRANCH | sed 's/.*\/v\(.*\)/\1/')
