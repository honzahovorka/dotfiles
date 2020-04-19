# Defined in /Users/honzahovorka/.config/fish/functions/clean_docker.fish @ line 2
function clean_docker
	remove-docker-images
  echo "Fucking shit, those silly fucking whales eating my fucking disk"
  docker volume rm (docker volume ls -qf dangling=true)
  echo "done m8"
end
