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
### github
```bash
# automatically create remote branches to push to
git config --global --add --bool push.autoSetupRemote true
```

merge main into dev branch:
```
git checkout custom_branch && git rebase master
```