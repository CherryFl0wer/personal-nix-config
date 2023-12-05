{ config, pkgs, ... } : {
    programs.firefox = {
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
            :root {
              --focus-outline-color: ${config.theme.colors.base04} !important;
              --toolbar-color: ${config.theme.colors.base07} !important;
              --tab-min-height: 30px !important;
            }
            /* Background of tab bar */
            .toolbar-items {
              background-color: ${config.theme.colors.base00} !important;
            }
            /* Extra tab bar sides on macOS */
            .titlebar-spacer {
              background-color: ${config.theme.colors.base00} !important;
            }
            .titlebar-buttonbox-container {
              background-color: ${config.theme.colors.base00} !important;
            }
            #tabbrowser-tabs {
              border-inline-start: 0 !important;
            }
            /* Private Browsing indicator on macOS */
            #private-browsing-indicator-with-label {
              background-color: ${config.theme.colors.base00} !important;
              margin-inline: 0 !important;
              padding-inline: 7px;
            }
            /* Tabs themselves */
            .tabbrowser-tab .tab-stack {
              border-radius: 5px 5px 0 0;
              overflow: hidden;
              background-color: ${config.theme.colors.base00};
              color: ${config.theme.colors.base06} !important;
            }
            .tab-content {
              border-bottom: 2px solid color-mix(in srgb, var(--identity-tab-color) 40%, transparent);
              border-radius: 5px 5px 0 0;
              background-color: ${config.theme.colors.base00};
              color: ${config.theme.colors.base06} !important;
            }
            .tab-content[selected] {
              border-bottom: 2px solid color-mix(in srgb, var(--identity-tab-color) 25%, transparent);
              background-color: ${config.theme.colors.base01} !important;
              color: ${config.theme.colors.base07} !important;
            }
            /* Below tab bar */
            #nav-bar {
              background: ${config.theme.colors.base01} !important;
            }
            /* URL bar in nav bar */
            #urlbar[focused=true] {
              color: ${config.theme.colors.base07} !important;
              background: ${config.theme.colors.base02} !important;
              caret-color: ${config.theme.colors.base05} !important;
            }
            #urlbar:not([focused=true]) {
              color: ${config.theme.colors.base04} !important;
              background: ${config.theme.colors.base02} !important;
            }
            #urlbar ::-moz-selection {
              color: ${config.theme.colors.base07} !important;
              background: ${config.theme.colors.base02} !important;
            }
            #urlbar-input-container {
              border: 1px solid ${config.theme.colors.base01} !important;
            }
            #urlbar-background {
              background: ${config.theme.colors.base01} !important;
            }
            /* Text in URL bar */
            #urlbar-input, #urlbar-scheme, .searchbar-textbox {
              color: ${config.theme.colors.base07} !important;
            }
            '';
            userContent = ''
            @-moz-document url-prefix(about:blank) {
              * {
                background-color:${config.theme.colors.base01} !important;
              }
            }
            '';

          extraConfig = "";
        };
    };
}