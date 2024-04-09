# Script to update npm packages in a project.

Write-Host "-----------------------------------------------------------------"
if (Test-Path node_modules) {
    Write-Host "Removing node_modules folder..."
    Remove-Item -Recurse -Force node_modules
} else {
    Write-Host "node_modules folder does not exist, skipping..."
}

Write-Host "-----------------------------------------------------------------"
if (Test-Path package-lock.json) {
    Write-Host " Removing package-lock.json..."
    Remove-Item -Force package-lock.json
} else {
    Write-Host " package-lock.json does not exist, skipping..."
}

Write-Host "-----------------------------------------------------------------"
Write-Host "Installing npm-check-updates globally..."
npm i -g npm-check-updates
if (-not $?) {
    Write-Host "Failed to install npm-check-updates globally."
    exit 1
}

Write-Host "-----------------------------------------------------------------"
Write-Host "Updating package.json..."
ncu -u
if (-not $?) {
    Write-Host "Failed to update package.json."
    exit 1
}

Write-Host "-----------------------------------------------------------------"
Write-Host "Installing the updated packages..."
npm install
if (-not $?) {
    Write-Host "Failed to install the updated packages."
    exit 1
}

Write-Host "-----------------------------------------------------------------"
Write-Host "Process completed successfully."