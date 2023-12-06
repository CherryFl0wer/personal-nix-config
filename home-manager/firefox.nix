{ config, pkgs, ... } : {
    programs.firefox = {
        enable = true;
        profiles.default = {
            id = 0;
            name = "default";
            isDefault = true;
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                ublock-origin
                vimium
                multi-account-containers
                facebook-container
                sponsorblock
                reddit-enhancement-suite
                return-youtube-dislikes
                markdownload
                snowflake
                don-t-fuck-with-paste
                i-dont-care-about-cookies
            ];
            settings = {
                "app.update.auto" = false;
                "browser.aboutConfig.showWarning" = false;
                "browser.warnOnQuit" = false;
                "browser.quitShortcut.disabled" = true;
                "browser.theme.dark-private-windows" = true;
                "browser.toolbars.bookmarks.visibility" = false;
                "browser.startup.page" = 3; # Restore previous session
                "browser.newtabpage.enabled" = false; # Make new tabs blank
                "trailhead.firstrun.didSeeAboutWelcome" = true; # Disable welcome splash
                "dom.forms.autocomplete.formautofill" = false; # Disable autofill
                "extensions.formautofill.creditCards.enabled" = false; # Disable credit cards
                "dom.payments.defaults.saveAddress" = false; # Disable address save
                "general.autoScroll" = true; # Drag middle-mouse to scroll
                "services.sync.prefs.sync.general.autoScroll" = false; # Prevent disabling autoscroll
                "extensions.pocket.enabled" = false;
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allow userChrome.css
                "layout.css.color-mix.enabled" = true;
                "ui.systemUsesDarkTheme" = 1;
                "media.ffmpeg.vaapi.enabled" = true; # Enable hardware video acceleration
                "cookiebanners.ui.desktop.enabled" = true; # Reject cookie popups
                "devtools.command-button-screenshot.enabled" = true; # Scrolling screenshot of entire page
                "svg.context-properties.content.enabled" = true; # Sidebery styling
            };
            userChrome = ''
            @-moz-document url(chrome://browser/content/browser.xhtml) {
          /* tabs on bottom of window */
          #main-window body { flex-direction: column-reverse !important; }
          #navigator-toolbox { flex-direction: column-reverse !important; }
          #urlbar {
            top: unset !important;
            bottom: calc((var(--urlbar-toolbar-height) - var(--urlbar-height)) / 2) !important;
            box-shadow: none !important;
            display: flex !important;
            flex-direction: column !important;
          }
          #urlbar-input-container {
            order: 2;
          }
          #urlbar > .urlbarView {
            order: 1;
            border-bottom: 1px solid #666;
          }
          #urlbar-results {
            display: flex;
            flex-direction: column-reverse;
          }
          .search-one-offs { display: none !important; }
          .tab-background { border-top: none !important; }
          #navigator-toolbox::after { border: none; }
          #TabsToolbar .tabbrowser-arrowscrollbox,
          #tabbrowser-tabs, .tab-stack { min-height: 28px !important; }
          .tabbrowser-tab { font-size: 80%; }
          .tab-content { padding: 5px 5px; }
          .tab-close-button .toolbarbutton-icon { width: 12px !important; height: 12px !important; }
          toolbox[inFullscreen=true] { display: none; }
          /*
          * the following makes it so that the on-click panels in the nav-bar
          * extend upwards, not downwards. some of them are in the #mainPopupSet
          * (hamburger + unified extensions), and the rest are in
          * #navigator-toolbox. They all end up with an incorrectly-measured
          * max-height (based on the distance to the _bottom_ of the screen), so
          * we correct that. The ones in #navigator-toolbox then adjust their
          * positioning automatically, so we can just set max-height. The ones
          * in #mainPopupSet do _not_, and so we need to give them a
          * negative margin-top to offset them *and* a fixed height so their
          * bottoms align with the nav-bar. We also calc to ensure they don't
          * end up overlapping with the nav-bar itself. The last bit around
          * cui-widget-panelview is needed because "new"-style panels (those
          * using "unified" panels) don't get flex by default, which results in
          * them being the wrong height.
          *
          * Oh, yeah, and the popup-notification-panel (like biometrics prompts)
          * of course follows different rules again, and needs its own special
          * rule.
          */
          #mainPopupSet panel.panel-no-padding { margin-top: calc(-50vh + 40px) !important; }
          #mainPopupSet .panel-viewstack, #mainPopupSet popupnotification { max-height: 50vh !important; height: 50vh; }
          #mainPopupSet panel.panel-no-padding.popup-notification-panel { margin-top: calc(-50vh - 35px) !important; }	
          #navigator-toolbox .panel-viewstack { max-height: 75vh !important; }
          panelview.cui-widget-panelview { flex: 1; }
          panelview.cui-widget-panelview > vbox { flex: 1; min-height: 50vh; }
        }
            '';

            extraConfig = "";
        };
    };
}