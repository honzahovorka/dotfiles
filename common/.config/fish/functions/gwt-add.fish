function gwt-add
    if test (count $argv) -eq 0
        echo "Usage: gwt-add <branch-name>"
        return 1
    end

    set branch_name $argv[1]
    git worktree add $branch_name -b $branch_name
    cd $branch_name
end
