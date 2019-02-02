workflow "Lint I18n" {
  on = "pull_request"
  resolves = ["Run Lint"]
}

action "Run Lint" {
  uses = "marceloalves/action-translator@master"
  secrets = ["GITHUB_TOKEN"]
}
