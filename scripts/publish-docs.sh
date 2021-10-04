#!/usr/bin/env bash

set -e
set -o pipefail
set -u

if ! [[ -d "${VERSION}" ]]; then
  echo "${VERSION} directory does not exist"
  exit 1
fi

if ! [[ "${VERSION}" =~ ^([0-9]+\.){2}[0-9]+(-.+)?$ ]]; then
  echo "Set \$VERSION to a valid semver version"
  exit 1
fi


git checkout publisher-production
BRANCH="docs-${VERSION}" # push directly to publisher-production when verified on a release tag
git checkout "${BRANCH}" || git checkout -b "${BRANCH}"
git add "${VERSION}"
git commit -m "v${VERSION} [skip ci]"
git push origin "${BRANCH}"