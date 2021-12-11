#!/bin/bash

cp scripts/pre-commit .git/hooks/pre-commit
cp scripts/post-commit .git/hooks/post-commit

chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/post-commit
