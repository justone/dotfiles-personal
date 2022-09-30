#!/bin/bash

function prompt_text () {
  dir=$1

  if [[ $dir == $HOME ]]; then
    echo "🏠"
  elif [[ $dir == "$HOME/projects/"* ]]; then
    echo "📁 "${dir#"$HOME/projects/"}
  elif [[ $dir == "$HOME"* ]]; then
    echo "🏠 "${dir#"$HOME/"}
  else
    echo $dir
  fi
}

function try_out () {
  echo " in: "$1
  echo "out: $(prompt_text $1)"

}

try_out "/Users/njones/projects/sa-safe/nate-scratch"
try_out "/Users/njones/projects/sa-safe"
try_out "/Users/njones/projects"
try_out "/Users/njones"
try_out "/usr/local/bin"
