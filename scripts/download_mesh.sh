#! /bin/bash

# Download the mesh resources:
mkdir -p models/mockup_nix/mesh
cd models/mockup_nix/mesh
echo "Downloading md5 check file"
wget --quiet https://www.dropbox.com/s/1gmnnnum9v0qezf/mockup_nix.md5?dl=1 -O mockup_nix.md5
md5sum --status --check mockup_nix.md5
Result=$?
if [[ $Result -eq 0 ]]
then
    echo "Nix mesh already downloaded"
else
    echo "MD5 check of the mesh failed. Downloading Nix mockup's mesh."
    wget --quiet https://www.dropbox.com/s/tpcqfmahtj9qxmg/mockup_nix.dae?dl=1 -O mockup_nix.dae
    echo "Checking MD5 again."
    ls -l
    md5sum -c mockup_nix.md5
    Result=$?
    if [[ $Result -ne 0 ]]
    then
        echo "MD5 error when downloaded the NIX mockup's mesh. Aborting."
        exit -1
    fi
    cd ../../../../../          # Going back to the root of the workspace
fi
