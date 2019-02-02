workflow "Lint I18n" {
  on = "pull_request"
  resolves = ["MarceloAlves/action-translator@1133d26724a188c2cce98b5f4c418fda8bfbf77b"]
}

action "MarceloAlves/action-translator@1133d26724a188c2cce98b5f4c418fda8bfbf77b" {
  uses = "marceloalves/action-translator@master"
  secrets = ["GITHUB_TOKEN"]
}
