#!/bin/bash

# Define session and window names
SESSION_NAME="template"
WINDOW0="docker"
WINDOW1="serverpod-gen"
WINDOW2="riverpod-gen"
WINDOW3="server"

tmux new-session -d -s $SESSION_NAME -n $WINDOW0
tmux send-keys -t $SESSION_NAME:$WINDOW0 "cd template_server; docker compose up" C-m

tmux new-window -t $SESSION_NAME -n $WINDOW1
tmux send-keys -t $SESSION_NAME:$WINDOW1 "cd template_server; serverpod generate --watch" C-m

tmux new-window -t $SESSION_NAME -n $WINDOW2
tmux send-keys -t $SESSION_NAME:$WINDOW2 "cd template_flutter; dart run build_runner watch --delete-conflicting-outputs" C-m

tmux new-window -t $SESSION_NAME -n $WINDOW3
tmux send-keys -t $SESSION_NAME:$WINDOW3 "cd template_server; dart bin/main.dart --apply-migrations" C-m

# Attach to the tmux session
tmux attach -t $SESSION_NAME
