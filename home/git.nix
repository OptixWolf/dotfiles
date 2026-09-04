{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "OptixWolf";
        email = "62619140+OptixWolf@users.noreply.github.com";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
