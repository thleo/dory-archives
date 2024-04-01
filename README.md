# dory-archives
all the annoying config stuff that you forget


## shell commands + shortcuts
### aws
```bash
# run aws commands in prod without setting config
function awsprod ()
{
    echo '>>>' aws $@ --profile production; aws $@ --profile production
    
}
```
### git / github
```bash
# automatically create remote branches to push to
git config --global --add --bool push.autoSetupRemote true
```

```bash
git switch <branch>
```

#### merge main into dev branch:
```bash
git checkout custom_branch && git rebase main
```
#### squash commits into a new clean looking branch
```bash
nbranch new-clean-branch
git merge --squash old-messy-branch-with-many-commits
```

### shell docs for prompt customisation
- [Prompt time display cheatsheet][1]

[1]:https://www.tweaking4all.com/software/macosx-software/customize-zsh-prompt/