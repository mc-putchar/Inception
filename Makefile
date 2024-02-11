# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcutura <mcutura@student.42berlin.de>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/29 14:49:52 by mcutura           #+#    #+#              #
#    Updated: 2024/02/11 10:35:34 by mcutura          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	:= inception

# --- DIRS ---
WPDIR	:= ${HOME}/data/wordpress
DBDIR	:= ${HOME}/data/db-wordpress
WEBDIR	:= ${HOME}/data/site-content
SSLDIR	:= ${HOME}/data/ssl
ADMDIR	:= ${HOME}/data/adminer

# --- FILES ---
COMPOSE	:= srcs/compose.yaml
ENV		:= srcs/.env srcs/mariadb.env srcs/wp.env

# --- TOOLS ---
DC		:= docker compose
DIR		:= mkdir -p
RM		:= rm -fr

.PHONY: all dirs up down start stop clean help

init:	# Initialize data needed for the project
	@$(DIR) $(WPDIR) $(WEBDIR) $(DBDIR) $(SSLDIR) $(ADMDIR)
	@bash srcs/requirements/tools/init.sh

up:	# Run containers (re)building their images if needed
	$(DC) -p $(NAME) -f $(COMPOSE) up -d --build

down:	# Stop and remove containers
	$(DC) -f $(COMPOSE) down

start:	# Start containers
	$(DC) -f $(COMPOSE) start

stop:	# Stop containers
	$(DC) -f $(COMPOSE) stop

clean:	# Stop and remove all created containers, volumes and files
	- $(DC) -f $(COMPOSE) down -v
	- $(RM) $(WPDIR) $(WEBDIR) $(DBDIR) $(SSLDIR) $(PSWDDIR) $(ADMDIR)
	- $(RM) $(ENV)

fclean: clean	# Remove and reset everything. WARNING: prunes whole docker sys
	docker system prune --all --force

help:	# Print this helpful message
	@awk 'BEGIN { \
	FS = ":.*#"; printf "Usage:\n\tmake <target>\n\nTargets:\n"; } \
	/^[a-zA-Z_0-9-]+:.*?#/ { \
	printf "%-16s%s\n", $$1, $$2 } ' Makefile
