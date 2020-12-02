import XMonad

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.Navigation2D
import XMonad.Actions.Promote
import XMonad.Actions.WindowMenu

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run (safeSpawn)

import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed

import Control.Monad (forM_, join)

import Data.Function (on)
import Data.List (sortBy)
import Data.Ratio

import Graphics.X11.ExtraTypes.XF86

import System.Exit

import qualified XMonad.Prompt         as P
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S
import qualified XMonad.StackSet       as W

import qualified DBus                     as D
import qualified DBus.Client              as D
import qualified Data.Map                 as M
import qualified Codec.Binary.UTF8.String as UTF8


-----------------------------------------------------------------------------}}}
-- GLOBAL VARIABLES                                                          {{{
--------------------------------------------------------------------------------
-- General config
-- myWorkspaces    = ["\xe400","\xe401","\xe3fb","\xe3fd","\xe3fe","\xe3ff","\61705","\61564","\62150"]
myWorkspaces    = ["1", "2", "3", "4", "5", "6"]
myModMask       = mod1Mask
myTerminal      = "alacritty"
myBorderWidth   = 1
myWindowSpacing = 5
myBrowser       = "firefox"

-- Fonts
myFont       = "xft:Monospace:size=16"

-- Colors
-- cFocus    = "#b5bd68"
-- cFocus    = "#a3be8c"
-- cFocus    = "#83b8c7"
-- cFocus    = "#5f819d"
-- cFocus    = "#7d9cba"
cWhite    = "#ffffff"
cBlack    = "#1d1f21"
-- cFocus    = "#b48ced"
-- cFocus    = "#8ec07c"
-- cFocus    = "#d79921"
-- cFocus    = "#458588"
cFocus    = "#51afef"
-- cFocus    = "#83a598"
-- cFocus    = "#689d6a"
-- cNormal   = "#928374"
cNormal   = "#888888"
cUrgent   = "#bf616a"
cPurple   = "#b45bcf"
cInactive = "#444444"

-----------------------------------------------------------------------------}}}
-- CONFIG                                                                    {{{
--------------------------------------------------------------------------------
myConfig = def
    { modMask             = myModMask
    , terminal            = myTerminal
    , focusFollowsMouse   = False
    , clickJustFocuses    = False
    , workspaces          = myWorkspaces
    , borderWidth         = myBorderWidth
    , normalBorderColor   = cNormal
    , focusedBorderColor  = cFocus
    , keys                = myKeys
    , startupHook         = ewmhDesktopsStartup <+> myStartupHook
    , manageHook          = insertPosition Below Newer <+> myManageHook
    , layoutHook          = myLayoutHook
    -- , logHook             = ewmhDesktopsLogHook
    , handleEventHook     = ewmhDesktopsEventHook
    -- , handleEventHook     = handleEventHook def <+> fullscreenEventHook
    }


myNav2DConfig = def
    { defaultTiledNavigation = centerNavigation }


myTabConfig = def
    { fontName            = myFont
    , decoHeight          = 30
    , activeColor         = cFocus
    , activeBorderColor   = cFocus
    , inactiveColor       = cInactive
    , inactiveBorderColor = cInactive
    , activeTextColor     = cBlack
    }

myTheme = Theme {
    activeColor         = cFocus
  , inactiveColor       = cNormal
  , urgentColor         = "#ffff00"
  , inactiveBorderColor = cNormal
  , activeBorderColor   = cFocus
  , urgentBorderColor   = "#00ff00"
  , activeTextColor     = "white"
  , inactiveTextColor   = "black"
  , urgentTextColor     = "#FF0000"
  , fontName            = myFont
  , decoWidth           = 200
  , decoHeight          = 40
  , windowTitleAddons   = []
  , windowTitleIcons    = []
  }

-----------------------------------------------------------------------------}}}
-- STARTUPHOOK                                                               {{{
--------------------------------------------------------------------------------
myStartupHook = do
  -- spawn "$HOME/scripts/xmonad-autostart.sh"
  -- spawn "$HOME/scripts/xmonad-autostart.sh"
  spawn "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
  spawn "$HOME/.config/polybar/launch.sh"
  -- setWMName "LG3D"
  setWMName "Xmonad"


-----------------------------------------------------------------------------}}}
-- MANAGEHOOK                                                                {{{
--------------------------------------------------------------------------------
myManageHook = composeAll
    [ className =? "MPlayer"                   --> doFloat
    , className =? "mplayer2"                  --> doFloat
    , className =? "Pamac-manager"             --> doCenterFloat
    , className =? "pamac-manager"             --> doCenterFloat
    , className =? "Gcolor3"                   --> doCenterFloat
    , className =? "Xfce4-appearance-settings" --> doCenterFloat
    , className =? "VirtualBox Manager"        --> doFloat
    , title     =? "org-capture"               --> doRectFloat (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 3)) ]


-----------------------------------------------------------------------------}}}
-- LAYOUTHOOK                                                                {{{
--------------------------------------------------------------------------------
myLayoutHook =
    avoidStruts $
    spacingRaw True (Border 0 0 0 0) False (Border myWindowSpacing myWindowSpacing myWindowSpacing myWindowSpacing) True $
    -- onWorkspace "\xe401" Full $
    minimize (maximize (vertTiled ||| horzTiled ||| smartBorders (tabbed shrinkText myTabConfig) ||| smartBorders Full))

    where
        vertTiled      = smartBorders (Tall nMaster delta vRatio)

        horzTiled      = smartBorders (Mirror (Tall nMaster delta hRatio))

        -- The default number of windows in the master pane
        nMaster     = 1

        -- Percent of screen to increment by when resizing panes
        delta       = 3/100

        -- Default proportion of screen occupied by master pane in vertical tiled mode
        vRatio      = 1/2

        -- Default proportion of screen occupied by master pane in horizontal tiled mode
        hRatio      = 4/5


-----------------------------------------------------------------------------}}}
-- LOGHOOK                                                                   {{{
--------------------------------------------------------------------------------
myLogHook :: PP
myLogHook = def
    { ppCurrent = wrap ("%{F" ++ cFocus ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ cWhite ++ "} ") " %{F-}"
    , ppUrgent  = wrap ("%{F" ++ cUrgent ++ "} ") " %{F-}"
    , ppHidden  = wrap ("%{F" ++ cNormal ++ "} ") " %{F-}"
    -- , ppHidden  = wrap " " " "
    , ppWsSep   = ""
    , ppOrder   = \(ws:_:t:_) -> [ws,t]
    , ppSep     = " • "
    , ppTitle   = shorten 100 }

myDBusLogHook :: D.Client -> PP
myDBusLogHook dbus = def
    { ppOutput  = dbusOutput dbus
    , ppCurrent = wrap ("%{F" ++ cFocus ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ cWhite ++ "} ") " %{F-}"
    , ppUrgent  = wrap ("%{F" ++ cUrgent ++ "} ") " %{F-}"
    , ppHidden  = wrap ("%{F" ++ cNormal ++ "} ") " %{F-}"
    -- , ppHidden  = wrap " " " "
    , ppWsSep   = ""
    , ppOrder   = \(ws:_:t:_) -> [ws,t]
    , ppSep     = " • "
    , ppTitle   = shorten 100 }

myEventLogHook = do
    winset <- gets windowset
    title <- maybe (return "") (fmap show . getName) . W.peek $ winset
    let currWs = W.currentTag winset
    let wss = map W.tag $ W.workspaces winset
    let wsStr = join $ map (fmt currWs) $ sort' wss

    io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
    io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

  where fmt currWs ws
          | currWs == ws = "%{F" ++ cFocus ++ "} " ++ ws ++ " %{F-}"
          | otherwise    = "%{F" ++ cNormal ++ "} " ++ ws ++ " k{F-}"
        sort' = sortBy (compare `on` (!! 0))

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"


-----------------------------------------------------------------------------}}}
-- KEYBINDINGS                                                               {{{
--------------------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launchers
    [ ((modMask,                xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask,  xK_Return), spawn "alacritty -e tmux")
    , ((modMask,                xK_space ), spawn "~/.config/rofi/scripts/launcher")
    , ((modMask .|. shiftMask,  xK_0     ), spawn "~/.config/rofi/scripts/calc")
    , ((modMask .|. shiftMask,  xK_n     ), spawn "~/.config/rofi/scripts/networkmanager-dmenu")
    , ((modMask .|. shiftMask,  xK_c     ), spawn "~/.config/rofi/scripts/clipboard")
    , ((modMask .|. shiftMask,  xK_w     ), spawn "~/.config/rofi/scripts/windows")
    , ((modMask .|. shiftMask,  xK_s     ), spawn "xfce4-screenshooter")
    , ((modMask .|. controlMask,xK_space ), spawn "~/.config/rofi/scripts/filebrowser")
    , ((mod4Mask,               xK_r     ), spawn "alacritty -e ranger")
    , ((mod4Mask,               xK_e     ), spawn "emacs")
    , ((mod4Mask,               xK_m     ), spawn "alacritty -e neomutt")
    , ((mod4Mask,               xK_n     ), spawn "alacritty -e newsboat")

    , ((modMask,                xK_q     ), kill1)

    -- misc
    , ((modMask,                xK_g     ), goToSelected def) -- %! Show open windows in grid

    -- quit, or restart
    , ((modMask .|. shiftMask,  xK_q     ), io (exitWith ExitSuccess))
    , ((modMask .|. shiftMask,  xK_r     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
    , ((modMask,                xK_0     ), spawn "~/.config/rofi/scripts/powermenu")

    -- layout stuff
    , ((mod4Mask,               xK_space ), sendMessage NextLayout)             -- %! Rotate through the available layout algorithms

    -- maximize/minimize
    , ((mod4Mask,               xK_z     ), withFocused (sendMessage . maximizeRestore))

    -- focus and master window handling
    , ((modMask,                xK_Tab   ), windows W.focusDown)
    , ((modMask .|. shiftMask,  xK_Tab   ), windows W.focusUp)
    , ((modMask,                xK_m     ), windows W.focusMaster)
    , ((mod4Mask,               xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask,  xK_m     ), promote)
    , ((modMask,                xK_j     ), windows W.focusDown)
    , ((modMask,                xK_k     ), windows W.focusUp)
    , ((modMask,                xK_h     ), windows W.focusMaster)
    -- , ((modMask,                xK_l     ), windows W.focusDown)
    , ((modMask .|. shiftMask,  xK_h     ), windows W.swapMaster)
    , ((modMask .|. shiftMask,  xK_l     ), windows W.swapDown)
    , ((modMask .|. shiftMask,  xK_j     ), windows W.swapDown)
    , ((modMask .|. shiftMask,  xK_k     ), windows W.swapUp)
    -- , ((modMask,                xK_h     ), windowGo L False)
    -- , ((modMask,                xK_j     ), windowGo D False)
    -- , ((modMask,                xK_k     ), windowGo U False)
    -- , ((modMask,                xK_l     ), windowGo R False)
    -- , ((modMask .|. shiftMask,  xK_h     ), windowSwap L False)
    -- , ((modMask .|. shiftMask,  xK_j     ), windowSwap D False)
    -- , ((modMask .|. shiftMask,  xK_k     ), windowSwap U False)
    -- , ((modMask .|. shiftMask,  xK_l     ), windowSwap R False)

    -- switch between layers
    , ((mod4Mask,               xK_Tab   ), switchLayer)

    -- directional navigation of screens
    , ((mod4Mask,               xK_l     ), screenGo R False)
    , ((mod4Mask,               xK_h     ), screenGo L False)
    , ((mod4Mask,               xK_k     ), screenGo U False)
    , ((mod4Mask,               xK_j     ), screenGo D False)

    -- Swap adjacent screens
    -- , ((mod4Mask .|. shiftMask, xK_l    ), screenSwap R False)
    -- , ((mod4Mask .|. shiftMask, xK_h    ), screenSwap L False)
    -- , ((mod4Mask .|. shiftMask, xK_k    ), screenSwap U False)
    -- , ((mod4Mask .|. shiftMask, xK_j    ), screenSwap D False)

    -- resizing the master/slave ratio
    , ((mod4Mask .|. shiftMask, xK_minus ), sendMessage Shrink)                 -- %! Shrink the master area
    , ((mod4Mask .|. shiftMask, xK_plus  ), sendMessage Expand)                 -- %! Expand the master area
    , ((mod4Mask .|. shiftMask, xK_0     ), setLayout $ XMonad.layoutHook conf) -- %! Reset the layouts on the current workspace to default

    -- floating layer support
    , ((mod4Mask,               xK_f     ), withFocused $ windows . W.sink)    -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask,                xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask,                xK_period), sendMessage (IncMasterN (-1)))

    -- brightness controls
    , ((0,       xF86XK_MonBrightnessUp  ), spawn "sh -c \"brightnessctl set 5%+ && ~/scripts/brightness-notification.sh\"")
    , ((0,       xF86XK_MonBrightnessDown), spawn "sh -c \"brightnessctl set 5%- && ~/scripts/brightness-notification.sh\"")

    -- volu
    , ((0,       xF86XK_AudioRaiseVolume ), spawn "sh -c \"amixer -D pulse sset Master 5%+ && ~/scripts/audio-notification.sh\"")
    , ((0,       xF86XK_AudioLowerVolume ), spawn "sh -c \"amixer -D pulse sset Master 5%- && ~/scripts/audio-notification.sh\"")
    , ((0,       xF86XK_AudioMute        ), spawn "sh -c \"amixer sset Master toggle && ~/scripts/audio-notification.sh\"")
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)]]
    ++
    -- mod4-{1,2,3} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod4-shift-{1,2,3} %! Move client to screen 1, 2, or 3
    [((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_1, xK_2, xK_3] [0,2,1]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-----------------------------------------------------------------------------}}}
-- MAIN                                                                      {{{
--------------------------------------------------------------------------------
main :: IO ()
main = do
    -- forM_ [".xmonad-workspace-log", ".xmonad-title-log", ".xmonad-screen-log"] $ \file -> do
    --     safeSpawn "mkfifo" ["/tmp/" ++ file]

    dbus <- D.connectSession
    -- Request access to the DBus name
    _ <- D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad
        -- $ docks myConfig
        $ docks
        -- $ withNavigation2DConfig def
        $ ewmh
        $ myConfig { logHook = dynamicLogWithPP (myDBusLogHook dbus) }
