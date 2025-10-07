#!/bin/bash

# Quick Push Script for Linux/WSL
# CST-405 Compiler Project

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          PUSHING TO GITHUB                                ║"
echo "║          Repository: aimemoria/CST-405                    ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

cd "$(dirname "$0")"

echo "Checking git status..."
git status

echo ""
echo "Pushing to GitHub..."
echo "Repository: https://github.com/aimemoria/CST-405.git"
echo ""

git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║          PUSH SUCCESSFUL! ✓                               ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
    echo "Verify at: https://github.com/aimemoria/CST-405"
else
    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║          PUSH FAILED - SEE INSTRUCTIONS BELOW             ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
    echo "If authentication failed, you need a Personal Access Token:"
    echo "1. Go to: https://github.com/settings/tokens"
    echo "2. Generate new token (classic)"
    echo "3. Select 'repo' scope"
    echo "4. Copy the token"
    echo "5. Run this script again"
    echo "6. Use token as password when prompted"
fi

echo ""
