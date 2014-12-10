--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
--import System.Process(rawSystem)
import Control.Monad(liftM)
import Data.Char(toLower)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe, hPutStrLn)
--import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Dmenu
import XMonad.Util.WorkspaceCompare(getSortByXineramaRule)
--import XMonad.Util.Paste(pasteSelection)
import Graphics.X11.Xlib(openDisplay)
import Graphics.X11.Xinerama(getScreenInfo)
import Graphics.X11.ExtraTypes.XF86
-- Graphics.X11.Xinerama (xineramaQueryScreens, xsi_width)
-- XMonad.Actions.WindowGo(runOrRaise)


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
--myTerminal      = "xterm"
myTerminal      = "mlterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
--myWorkspaces    = ["terminal", "web"] ++ map show [3..8] ++ ["bg"]
myWorkspaces    = ["terminal", "web"] ++ map show [3..9] ++ ["bg"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myToggleStrutsKey XConfig { XMonad.modMask = modm } = (modm , xK_b)
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_q     ), exitWithConfirm ExitSuccess)

    -- Restart xmonad
    -- `xmonad --restart` may automatically recompile this configure file.
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    --, ((modm              , xK_q     ), spawn "xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
--        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    --
    -- larry's setting
    --
    ++
    -- lock screen
    [ ((modm .|. shiftMask, xK_l     ), spawn "xscreensaver-command -lock")
    -- capture window
--    , ((0                 , xK_Print ), spawn "import -frame ~/Pictures/`date '+screenshot-%Y-%m-%d-%H%M%S%z.png'`")
    , ((0                 , xK_Print ), spawn "import -frame ~/Pictures/screenshots/`date '+screenshot-%Y-%m-%d-%H%M%S%z.png'`")
    -- capture screen
--    , ((modm              , xK_Print ), spawn "import -screen ~/Pictures/`date '+screenshot-%Y-%m-%d-%H%M%S%z.png'`")
    , ((modm              , xK_Print ), spawn "scrot -m 'screenshot-%Y-%m-%d-%H%M%S%z.png' -e 'mv $f ~/Pictures/screenshots/'")
    -- run filer
    --, ((modm              , xK_f     ), spawn "nautilus --new-window")
    , ((modm              , xK_f     ), spawn "thunar")
    -- run filer as root
    , ((modm .|. shiftMask, xK_f     ), spawn "gksu thunar")
    -- quit xmonad without warning
    , ((modm .|. shiftMask .|. controlMask, xK_q     ), io (exitWith ExitSuccess))
    -- paste X-selection-paste buffer
    -- , ((0                 , xK_Insert), pasteSelection)
    ]
    --
    -- settings for laptop
    --
    ++
    [ ((0                 , xF86XK_MonBrightnessUp ), spawn "xbacklight -steps 1 -inc 9")
    , ((0                 , xF86XK_MonBrightnessDown ), spawn "xbacklight -steps 1 -dec 9")
    , ((0                 , xF86XK_AudioMute ), spawn "~/scripts/local/volumecontrol.sh toggle")
    , ((0                 , xF86XK_AudioRaiseVolume ), spawn "~/scripts/local/volumecontrol.sh 1%+")
    , ((0                 , xF86XK_AudioLowerVolume ), spawn "~/scripts/local/volumecontrol.sh 1%-")
    ]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     --tiled   = gaps [(U,18), (R,23)] $ Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll . concat $
    [ [manageDocks]
    , [manageHook defaultConfig]
    , [ className =? c --> doFloat | c <- myFloats ]
    , [ resource  =? c --> doIgnore | c <- myIgnores ]
    , [ className =? "Firefox" <&&> resource =? "Dialog" --> doFloat ]
    , [ className =? "Gkrellm" <&&> resource =? "Gkrellm_conf" --> doFloat ]
    ]
    where
      myFloats = ["MPlayer", "Conky", "Tilda", "Zenity", "StepMania", "Qjackctl"]
      myIgnores = ["desktop_window", "kdesktop"]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()
myXmobarPP = xmobarPP
        { ppCurrent = xmobarColor "#ffff00" "" . wrap "[" "]"
        , ppTitle   = xmobarColor "#00ff00" "" . shorten 256
        , ppSort    = getSortByXineramaRule
        }
myLogHook_xmobar dest = dynamicLogWithPP myXmobarPP
        { ppOutput = hPutStrLn dest }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--myStartupHook = return ()
--myStartupHook = setWMName "LG3D"
myStartupHook = ewmhDesktopsStartup >> setWMName "LG3D"

------------------------------------------------------------------------
-- Status bars
myScreenSizes :: IO [Rectangle]
myScreenSizes = openDisplay "" >>= getScreenInfo
myDzenCommandLine :: Rectangle -> String
myDzenCommandLine (Rectangle _ _ _ screenHeight) = "~/scripts/local/status.sh \"$DISPLAY\" | dzen2 -fn '-*-ricty-bold-*-*-*-14-*-*-*-*-*-*-*' -h " ++ show height ++" -ta r -y " ++ show (screenHeight - height) ++ " -e 'button3=exec:'"
--myDzenCommandLine (Rectangle _ _ _ screenHeight) = "dzen2 -fn '7x13bold' -h " ++ show height ++" -ta r -y " ++ show (screenHeight - height)
    where height = 16

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
--main = xmonad defaults
--main = xmonad =<< xmobar defaults
--main = xmonad =<< dzen defaults
main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    --spawn "ps -A -w -w --no-header -o pid,command=WIDE-COMMAND-COLUMN | grep '[/]scripts/local/status.sh$' | awk '{print $1}' | xargs kill; ~/scripts/local/status.sh | dzen2 -fn '7x13bold' -h 16 -ta r -y $(( $(xrandr | sed -e '/Screen 0/! d;s/Sc[^c]*current [0-9]* x \\([0-9]*\\).*/\\1/') - 16))"
    screenSize <- myScreenSizes
    --spawn $ "ps -A -w -w --no-header -o pid,command=WIDE-COMMAND-COLUMN | grep '[/]scripts/local/status.sh '\"$DISPLAY\"'$' | awk '{print $1}' | xargs kill; ~/scripts/local/status.sh \"$DISPLAY\" | " ++ (myDzenCommandLine (head screenSize))
    spawn $ "ps -A -w -w --no-header -o pid,command=WIDE-COMMAND-COLUMN | grep '[/]scripts/local/status.sh '\"$DISPLAY\"'$' | awk '{print $1}' | xargs kill; " ++ (myDzenCommandLine (head screenSize))
    xmonad =<< statusBar
        "xmobar"
        myXmobarPP
        myToggleStrutsKey
        defaults
        { logHook = myLogHook_xmobar xmproc
        }

------------------------------------------------------------------------
-- pretty print

------------------------------------------------------------------------


------------------------------------------------------------------------
-- warn before quitting xmonad
--
exitWithConfirm :: ExitCode -> X ()
exitWithConfirm s = withConfirm "quit Xmonad?" $ io (exitWith s)

withConfirm :: String -> X () -> X ()
withConfirm msg f = whenX (confirm_dmenu msg) f

confirm_dmenu :: String -> X Bool
confirm_dmenu msg = isStringYes `liftM` dmenu [msg, "y", "n"]

-- Note that return value of function 'dmenu' have \n as last character.
isStringYes :: String -> Bool
isStringYes = (`elem` yess) . (map toLower) . (filter (/= '\n'))
    where yess = ["y", "yes"]

------------------------------------------------------------------------


-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
