# NodeJS Docker

This is just a template for me. Nothing fancy. Sometimes I have a hard time on repetitive task, so I created this for myself.

### What this does?

It's just a template where I need to host my app on docker. It's a bit tricky but get the job done :3

By passing the environment variable you can run it ^^. It contain mandatory Environment Variables like
`GIT_TOKEN`, `GIT_URL`, `BUILD_COMMAND`, and `RUN_COMMAND`.

### Note to Myself

- remove the `https://` from url for `GIT_URL`.
- **When using GitLab**
  - add `oauth2:` at the first line of `GIT_TOKEN`.
