curl --user ${CIRCLE_TOKEN}: \
    --request POST \
    --form revision=549d88dd0bb4b923f21a5101cde925731570bc94 \
    --form config=@config.yml \
    --form notify=false \
        https://circleci.com/api/v1.1/project/github/GIVIN-pick/pickofficial/tree/cart_functionality