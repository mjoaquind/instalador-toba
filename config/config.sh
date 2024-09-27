#!/bin/sh
export ZSH_THEME=gnzh

sed -i "s/^ZSH_THEME=.*/ZSH_THEME='$ZSH_THEME'/" /$HOME/.zshrc