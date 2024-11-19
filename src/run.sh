#!/bin/bash

nginx
spawn-fcgi -p 8080 /app/mini_server
tail -f /dev/null

/bin/bash