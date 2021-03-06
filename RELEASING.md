## Releasing Shopify CLI

1. Check the Semantic Versioning page for info on how to version the new release: http://semver.org

1. Make sure you're on the most recent `master`
   ```
   $ git checkout master
   $ git pull
   ```

1. Create a branch named `release_X_Y_Z` (replacing `X_Y_Z` with the intended release version)
   ```
   $ git checkout -b release_X_Y_Z
   ```

1. Update the version of Shopify CLI in `lib/shopify-cli/version.rb`

1. Add an entry for the new release to `CHANGELOG.md`

1. Commit the changes with a commit message like "Packaging for release X.Y.Z"
   ```
   $ git commit -am "Packaging for release vX.Y.Z"
   ```

1. Push out the changes
   ```
   $ git push -u origin release_X_Y_Z
   ```

1. Open a PR for the branch, get necessary approvals from code owners and merge into main branch. Note that the PR title will be the release note in Shipit, so make sure it mentions the release

1. Deploy using Shipit

1. Update your `master` branch to the latest version
   ```
   $ git checkout master
   $ git pull
   ```

1. On local machine and _AFTER_ gem has been published to https://rubygems.org, run
   ```
   $ rake package
   ```
   This will generate the `.deb`, `.rpm` and brew formula files, which will be located in `packaging/builds/X.Y.Z/`.

1. Check the "Actions" tab to see if the _Create Release_ workflow is successful. 
   The workflow will automatically create a release with the latest tag and the `.deb`, `.rpm` assets attached.

1. Check the `Shopify/homebrew-shopify` repository for new branch `bump-shopify-cli-{version}` and create PR.
