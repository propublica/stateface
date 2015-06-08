# Updating StateFace on Bower's Registry

1. Make whatever changes need making
2. Modify the `"version"` value in `bower.json`.  Please try to use [Semantic Versioning](http://semver.org).
3. Commit changes to `bower.json`
4. Push the changes to GitHub
5. Tag the repo with the same value you used in step #2

   ```
   git tag 1.1.0
   ```
6. Push the tags to GitHub

   ```
   git push --tags origin # or whatever remote name you use
   ```
7. The Bower registry should see that the new version is avalable

