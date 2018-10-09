# Turn the work-folder into GOPATH
export GOPATH=${SRC_DIR}
export PATH=${GOPATH}/bin:$PATH
pushd src/github.com/hashicorp/vault

# Git Initialize
# Apps tend to use git info to create version string
git init
git config --local user.email "conda@conda-forge.github.io"
git config --local user.name "conda-forge"

echo $PKG_VERSION >> VERSION
git add VERSION
git commit -m "conda build of $PKG_NAME-v$PKG_VERSION"
git tag v${PKG_VERSION}

# Build
make bootstrap

# This is a misnomer, it will still build the distro
make dev

# Install Binary into PREFIX/bin
mkdir -p $PREFIX/bin
mv $GOPATH/bin/$PKG_NAME $PREFIX/bin/${PKG_NAME}
