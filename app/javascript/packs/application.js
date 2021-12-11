// app/javascript/packs/application.js

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// Tailwind CSS
import "stylesheets/application";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
