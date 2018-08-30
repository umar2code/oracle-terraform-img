#!/bin/bash
curl -o soln.zip $TEMPLATE_URL
curl -o bmcs_api_key.pem $PRIVATE_KEY_URL
unzip -d . soln.zip
