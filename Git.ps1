function Push-All {
    Param(
        [Parameter(Mandatory=$true)]
        [String]
        $CommitMessage
    )

    git add .
    git commit -m $CommitMessage
    git push
}