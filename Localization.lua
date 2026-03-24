RaidCalendar = RaidCalendar or {}

---@class RaidCalendar
local m = RaidCalendar

if m.Localization then return end

---@class LocalizationModule
local M = {}

local registry = {}
local default_locale = "enUS"

local builtin_locales = {
	enUS = {
		days = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" },
		days_short = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" },
		months = {
			"January", "February", "March", "April", "May", "June",
			"July", "August", "September", "October", "November", "December"
		},
		months_short = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" },
		actions = {
			signup = "Signup",
			bench = "Bench",
			late = "Late",
			tentative = "Tentative",
			absence = "Absence",
			change_spec = "Change Spec",
			change = "Change",
			cancel = "Cancel",
			save = "Save",
			today = "Today",
			close = "Close",
			verify = "Verify",
			refresh_access = "Refresh Access",
			welcome_popup = "Welcome popup",
			reserve = "Reserve",
			lock_raid = "Lock raid",
			unlock_raid = "Unlock raid",
			check_absentees = "Check absentees",
			remove_absentees = "Remove absentees",
			show_all = "Show all",
			disconnect = "Disconnect"
		},
		options = {
			time_format_24 = "24-hour",
			time_format_12 = "12-hour",
			language_enUS = "English",
			language_frFR = "French"
		},
		time = {
			in_days_one = "in {count} day",
			in_days_many = "in {count} days",
			days_ago_one = "{count} day ago",
			days_ago_many = "{count} days ago",
			in_hours_one = "in {count} hour",
			in_hours_many = "in {count} hours",
			hours_ago_one = "{count} hour ago",
			hours_ago_many = "{count} hours ago",
			in_minutes_one = "in {count} minute",
			in_minutes_many = "in {count} minutes",
			minutes_ago_one = "{count} minute ago",
			minutes_ago_many = "{count} minutes ago"
		},
		ui = {
			refresh = "Refresh",
			settings = "Settings",
			close_window = "Close Window",
			invite_to_raid = "Invite to raid",
			link = "Link:",
			loading = "Loading...",
			hang_on_event = "Hang on while event data is loaded...",
			no_signup_data = "No signup data",
			signups = "{count} signups",
			more = "+{count} more",
			event_count_one = "{count} event",
			event_count_many = "{count} events",
			no_events_loaded = "No events loaded",
			day_schedule = "Day Schedule",
			no_events_day = "No events on this day",
			use_character_name = "Use character name instead of Discord name for signups",
			time_format = "Time format",
			language = "Language",
			select_language = "Select language",
			select_class = "Select class",
			select_spec = "Select spec",
			access_denied = "You do not have signup access for this event.",
			checking_access = "Checking access...",
			loading_events = "Loading events, please wait...",
			loaded = "(v{version}) Loaded",
			no_players_to_invite = "No players to invite",
			discord_not_set = "DiscordID is not set",
			class_not_selected = "Class not selected",
			spec_not_selected = "Spec not selected",
			discord_user_found = "Found user ID ({user_id}).",
			auth_request_sent = "Authorization request sent, waiting for response.\nCheck your Discord DM from {bot_name}.",
			welcome_title = "Welcome to RaidCalendar",
			welcome_info = "Before using RaidCalendar you need to link and verify your Discord account. Follow the instructions.",
			checking_bot = "Checking for bot in guild.",
			checking_bot_no_response = "Checking for bot in guild. No response!",
			discord_name_id = "Discord name/ID",
			enter_discord_username = "Enter your Discord username / server nickname.",
			bot_response = "Checking for bot in guild. Received response from \"{name}\".",
			no_user_id_found = "No user ID found for \"{name}\".",
			authorization_granted = "Authorization granted, you can now sign up to events. Click the minimap icon to begin.",
			authorization_denied = "Authorization denied!",
			welcome_close_prompt = "Show the welcome popup again on this character?\nYou can type /rc welcome to reopen it.",
			name_found = "Found UserID for \"{name}\"",
			name_not_found = "Name not found.",
			online_tooltip = "{bot} is {status}",
			online = "online",
			offline = "offline",
			tomorrow = "Tomorrow",
			in_distant_future = "In the distant future",
			upcoming_raids = "Upcoming raids",
			export_to_rollfor = "Export to RollFor",
			raid_locked = "Raid is locked",
			your_reservations = "Your reservations ({count}/{limit})",
			reserve_item = "Reserve item",
			comment = "Comment",
			loading_sr = "Please wait while SR data is loaded...",
			not_in_raid_group = "You are not in a raid group",
			no_absentees_found = "No absentees found",
			showing_absentees = "Showing {count} absentees",
			deleting_srs_left = "Deleting SRs, {count} remaining...",
			sr_for_title = "SR for {event} ({raid})",
			month_events = "Monthly Events",
			no_events_month = "No events this month",
			ui_theme = "UI Theme",
			shared = "Shared",
			other_items = "Other Items",
			sr_link = "SR:"
		},
		classes = {
			Druid = "Druid", Hunter = "Hunter", Mage = "Mage", Paladin = "Paladin", Priest = "Priest",
			Rogue = "Rogue", Shaman = "Shaman", Warlock = "Warlock", Warrior = "Warrior",
			Tank = "Tank", Healer = "Healer", Melee = "Melee", Ranged = "Ranged", Feral = "Feral"
		},
		specs = {
			Restoration = "Restoration", Restoration1 = "Restoration", Protection = "Protection", Protection1 = "Protection",
			Combat = "Combat", Arms = "Arms", Fury = "Fury", Fire = "Fire", Frost = "Frost", Arcane = "Arcane",
			Affliction = "Affliction", Shadow = "Shadow", Subtlety = "Subtlety", Marksmanship = "Marksmanship",
			Holy = "Holy", Holy1 = "Holy", Destruction = "Destruction", Elemental = "Elemental", Smite = "Smite",
			Demonology = "Demonology", Survival = "Survival", Guardian = "Guardian", Retribution = "Retribution",
			Beastmastery = "Beast Mastery", Discipline = "Discipline", Balance = "Balance", Enhancement = "Enhancement",
			Feral = "Feral", Assassination = "Assassination", Swords = "Swords", Dreamstate = "Dreamstate"
		}
	},
	frFR = {
		days = { "dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi" },
		days_short = { "dim", "lun", "mar", "mer", "jeu", "ven", "sam" },
		months = {
			"janvier", "février", "mars", "avril", "mai", "juin",
			"juillet", "août", "septembre", "octobre", "novembre", "décembre"
		},
		months_short = { "janv", "févr", "mars", "avr", "mai", "juin", "juil", "août", "sept", "oct", "nov", "déc" },
		actions = {
			signup = "Inscription",
			bench = "Remplaçant",
			late = "Retard",
			tentative = "Incertain",
			absence = "Absence",
			change_spec = "Changer spé",
			change = "Changer",
			cancel = "Annuler",
			save = "Enregistrer",
			today = "Aujourd'hui",
			close = "Fermer",
			verify = "Vérifier",
			refresh_access = "Rafraîchir l'accès",
			welcome_popup = "Fenêtre d'accueil",
			reserve = "Réserver",
			lock_raid = "Verrouiller le raid",
			unlock_raid = "Déverrouiller le raid",
			check_absentees = "Vérifier les absents",
			remove_absentees = "Retirer les absents",
			show_all = "Tout afficher",
			disconnect = "Déconnecter"
		},
		options = {
			time_format_24 = "24 heures",
			time_format_12 = "12 heures",
			language_enUS = "Anglais",
			language_frFR = "Français"
		},
		time = {
			in_days_one = "dans {count} jour",
			in_days_many = "dans {count} jours",
			days_ago_one = "il y a {count} jour",
			days_ago_many = "il y a {count} jours",
			in_hours_one = "dans {count} heure",
			in_hours_many = "dans {count} heures",
			hours_ago_one = "il y a {count} heure",
			hours_ago_many = "il y a {count} heures",
			in_minutes_one = "dans {count} minute",
			in_minutes_many = "dans {count} minutes",
			minutes_ago_one = "il y a {count} minute",
			minutes_ago_many = "il y a {count} minutes"
		},
		ui = {
			refresh = "Rafraîchir",
			settings = "Paramètres",
			close_window = "Fermer la fenêtre",
			invite_to_raid = "Inviter au raid",
			link = "Lien :",
			loading = "Chargement...",
			hang_on_event = "Patiente pendant le chargement des données de l'événement...",
			no_signup_data = "Aucune donnée d'inscription",
			signups = "{count} inscriptions",
			more = "+{count} de plus",
			event_count_one = "{count} événement",
			event_count_many = "{count} événements",
			no_events_loaded = "Aucun événement chargé",
			day_schedule = "Programme du jour",
			no_events_day = "Aucun événement ce jour-là",
			use_character_name = "Utiliser le nom du personnage au lieu du nom Discord pour les inscriptions",
			time_format = "Format de l'heure",
			language = "Langue",
			select_language = "Choisir la langue",
			select_class = "Choisir une classe",
			select_spec = "Choisir une spé",
			access_denied = "Tu n'as pas accès à l'inscription pour cet événement.",
			checking_access = "Vérification de l'accès...",
			loading_events = "Chargement des événements, patiente...",
			loaded = "(v{version}) Chargé",
			no_players_to_invite = "Aucun joueur à inviter",
			discord_not_set = "DiscordID n'est pas défini",
			class_not_selected = "Classe non sélectionnée",
			spec_not_selected = "Spécialisation non sélectionnée",
			discord_user_found = "ID utilisateur trouvé ({user_id}).",
			auth_request_sent = "Demande d'autorisation envoyée, en attente d'une réponse.\nVérifie ton DM Discord de {bot_name}.",
			welcome_title = "Bienvenue sur RaidCalendar",
			welcome_info = "Avant d'utiliser RaidCalendar, tu dois lier et vérifier ton compte Discord. Suis les instructions.",
			checking_bot = "Recherche du bot dans la guilde.",
			checking_bot_no_response = "Recherche du bot dans la guilde. Aucune réponse !",
			discord_name_id = "Nom/ID Discord",
			enter_discord_username = "Entre ton pseudo Discord / surnom serveur.",
			bot_response = "Recherche du bot dans la guilde. Réponse reçue de \"{name}\".",
			no_user_id_found = "Aucun ID utilisateur trouvé pour \"{name}\".",
			authorization_granted = "Autorisation accordée, tu peux maintenant t'inscrire aux événements. Clique sur l'icône de la mini-carte pour commencer.",
			authorization_denied = "Autorisation refusée !",
			welcome_close_prompt = "Afficher à nouveau la fenêtre d'accueil sur ce personnage ?\nTu peux taper /rc welcome pour la rouvrir.",
			name_found = "UserID trouvé pour \"{name}\"",
			name_not_found = "Nom introuvable.",
			online_tooltip = "{bot} est {status}",
			online = "en ligne",
			offline = "hors ligne",
			tomorrow = "Demain",
			in_distant_future = "Dans un futur lointain",
			upcoming_raids = "Raids à venir",
			export_to_rollfor = "Exporter vers RollFor",
			raid_locked = "Le raid est verrouillé",
			your_reservations = "Tes réservations ({count}/{limit})",
			reserve_item = "Réserver un objet",
			comment = "Commentaire",
			loading_sr = "Patiente pendant le chargement des SR...",
			not_in_raid_group = "Tu n'es pas dans un groupe de raid",
			no_absentees_found = "Aucun absent trouvé",
			showing_absentees = "Affichage de {count} absents",
			deleting_srs_left = "Suppression des SR, {count} restants...",
			sr_for_title = "SR pour {event} ({raid})",
			month_events = "Les sorties du mois",
			no_events_month = "Aucune sortie ce mois-ci",
			ui_theme = "Thème UI",
			shared = "Partagé",
			other_items = "Autres objets",
			sr_link = "SR :"
		},
		classes = {
			Druid = "Druide", Hunter = "Chasseur", Mage = "Mage", Paladin = "Paladin", Priest = "Prêtre",
			Rogue = "Voleur", Shaman = "Chaman", Warlock = "Démoniste", Warrior = "Guerrier",
			Tank = "Tank", Healer = "Soigneur", Melee = "Mêlée", Ranged = "Distance", Feral = "Farouche"
		},
		specs = {
			Restoration = "Restauration", Restoration1 = "Restauration", Protection = "Protection", Protection1 = "Protection",
			Combat = "Combat", Arms = "Armes", Fury = "Fureur", Fire = "Feu", Frost = "Givre", Arcane = "Arcane",
			Affliction = "Affliction", Shadow = "Ombre", Subtlety = "Finesse", Marksmanship = "Précision",
			Holy = "Sacré", Holy1 = "Sacré", Destruction = "Destruction", Elemental = "Élémentaire", Smite = "Châtiment",
			Demonology = "Démonologie", Survival = "Survie", Guardian = "Gardien", Retribution = "Vindicte",
			Beastmastery = "Maîtrise des bêtes", Discipline = "Discipline", Balance = "Équilibre", Enhancement = "Amélioration",
			Feral = "Farouche", Assassination = "Assassinat", Swords = "Épées", Dreamstate = "Rêve d'émeraude"
		}
	}
}

local legacy_key_map = {
	["Refresh"] = "ui.refresh",
	["Settings"] = "ui.settings",
	["Close Window"] = "ui.close_window",
	["Today"] = "actions.today",
	["Signup"] = "actions.signup",
	["Bench"] = "actions.bench",
	["Late"] = "actions.late",
	["Tentative"] = "actions.tentative",
	["Absence"] = "actions.absence",
	["Change Spec"] = "actions.change_spec",
	["Change"] = "actions.change",
	["Cancel"] = "actions.cancel",
	["Save"] = "actions.save",
	["Close"] = "actions.close",
	["Verify"] = "actions.verify",
	["Refresh Access"] = "actions.refresh_access",
	["Welcome popup"] = "actions.welcome_popup",
	["Reserve"] = "actions.reserve",
	["Lock raid"] = "actions.lock_raid",
	["Unlock raid"] = "actions.unlock_raid",
	["Check absentees"] = "actions.check_absentees",
	["Remove absentees"] = "actions.remove_absentees",
	["Show all"] = "actions.show_all",
	["24-hour"] = "options.time_format_24",
	["12-hour"] = "options.time_format_12",
	["English"] = "options.language_enUS",
	["French"] = "options.language_frFR",
}

local function deep_get(root, path)
	if type(root) ~= "table" or type(path) ~= "string" or path == "" then
		return nil
	end

	local value = root
	for segment in string.gmatch(path, "([^.]+)") do
		if type(value) ~= "table" then
			return nil
		end
		value = value[segment]
		if value == nil then
			return nil
		end
	end

	return value
end

local function deep_merge(base, override)
	if type(base) ~= "table" then
		base = {}
	end

	if type(override) ~= "table" then
		return base
	end

	for key, value in pairs(override) do
		if type(value) == "table" then
			base[key] = deep_merge(type(base[key]) == "table" and base[key] or {}, value)
		else
			base[key] = value
		end
	end

	return base
end

local function copy_builtin_locales()
	for locale, data in pairs(builtin_locales) do
		if registry[locale] == nil then
			registry[locale] = deep_merge({}, data)
		end
	end
end

local function get_locale_table(locale)
	copy_builtin_locales()
	return registry[locale] or registry[default_locale] or builtin_locales[default_locale] or {}
end

local function resolve_key(key)
	if type(key) ~= "string" or key == "" then
		return nil
	end

	if deep_get(m.locale, key) or deep_get(get_locale_table(default_locale), key) then
		return key
	end

	if legacy_key_map[key] then
		return legacy_key_map[key]
	end

	return nil
end

--- Returns the display name of a locale in its OWN language (e.g. "Français" for frFR, regardless of current locale)
function M.locale_native_name( locale_code )
	copy_builtin_locales()
	local t = registry[ locale_code ] or builtin_locales[ locale_code ] or {}
	-- Use the locale's own name for itself stored under options.language_<code>
	local options = t.options or {}
	local key = "language_" .. locale_code
	return options[ key ] or locale_code
end

function M.register(locale, data)
	if type(locale) ~= "string" or locale == "" or type(data) ~= "table" then
		return
	end

	registry[locale] = deep_merge(type(registry[locale]) == "table" and registry[locale] or {}, data)
end

function M.set_locale(locale)
	copy_builtin_locales()
	local selected = type(locale) == "string" and registry[locale] and locale or default_locale
	m.locale_flag = selected
	m.locale = get_locale_table(selected)
	return selected
end

function M.get_locale()
	return m.locale_flag or default_locale
end

function M.translate(key, vars)
	local resolved_key = resolve_key(key) or key
	local value = deep_get(m.locale, resolved_key) or deep_get(get_locale_table(default_locale), resolved_key)
	if type(value) ~= "string" then
		return key
	end

	if type(vars) == "table" then
		value = string.gsub(value, "{([%w_]+)}", function(name)
			local replacement = vars[name]
			if replacement == nil then
				return "{" .. name .. "}"
			end
			return tostring(replacement)
		end)
	end

	return value
end

function M.text(key, vars)
	local resolved_key = resolve_key(key)
	if resolved_key then
		return M.translate(resolved_key, vars)
	end
	return type(key) == "string" and key or ""
end

function M.translate_text(text)
	return M.text(text)
end

function M.term(text)
	return M.text(text)
end

function M.class_name(text)
	return M.translate("classes." .. tostring(text))
end

function M.spec_name(text)
	return M.translate("specs." .. tostring(text))
end

function M.get_day_name(index, short)
	local key = short and "days_short" or "days"
	local names = deep_get(m.locale, key) or deep_get(get_locale_table(default_locale), key) or {}
	return names[index] or tostring(index)
end

function M.get_month_name(index, short)
	local key = short and "months_short" or "months"
	local names = deep_get(m.locale, key) or deep_get(get_locale_table(default_locale), key) or {}
	return names[index] or tostring(index)
end

function M.format_date(timestamp, style)
	local info = date("*t", timestamp)
	if style == "weekday_day_month" then
		return string.format("%s %d. %s", M.get_day_name((tonumber(date("%w", timestamp)) or 0) + 1, false), info.day, M.get_month_name(info.month, false))
	elseif style == "day_month_year" then
		return string.format("%02d. %s %d", info.day, M.get_month_name(info.month, false), info.year)
	elseif style == "day_shortmonth_year_time" then
		return string.format("%02d. %s %d %s", info.day, M.get_month_name(info.month, true), info.year, date(m.time_format, timestamp))
	elseif style == "day_month_year_compact" then
		return string.format("%02d %s %d", info.day, M.get_month_name(info.month, false), info.year)
	elseif style == "month_year" then
		return string.format("%s %d", M.get_month_name(info.month, false), info.year)
	end

	return date("%c", timestamp)
end

copy_builtin_locales()

m.register_locale = M.register
m.set_locale = M.set_locale
m.L = M.translate
m.text = M.text
m.locale_native_name = M.locale_native_name
m.translate_text = M.translate_text
m.localize_term = M.term
m.class_name = M.class_name
m.spec_name = M.spec_name
m.localize_class = M.class_name
m.get_day_name = M.get_day_name
m.get_month_name = M.get_month_name
m.format_local_date = M.format_date
m.Localization = M

return M
