#If new library comes then have to:
## Manually
```
git add libs/...
git commit -m "Update ... submodule"
git push
```
## Or autoamtically
```
git submodule update --remote --recursive
```