let
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIORP0oZKVbTkCYd4NXrvZF6fT3PvaPZ1gFbMMja/sybL agenix";
in
{
  # agenix -e listenbrainz.age -i ~/.ssh/masterkey
  "listenbrainz.age".publicKeys = [ key ];
}
