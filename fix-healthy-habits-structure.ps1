$ErrorActionPreference = "Stop"

Write-Host "Healthy Habits Tracker - project structure repair" -ForegroundColor Cyan

if (-not (Test-Path ".\package.json")) {
    Write-Host "ERROR: Run this script from the root of the healthy-habits-tracker repository." -ForegroundColor Red
    exit 1
}

$folders = @(
    ".\script",
    ".\client",
    ".\client\public",
    ".\client\src",
    ".\client\src\components",
    ".\client\src\components\ui",
    ".\client\src\lib",
    ".\client\src\hooks",
    ".\client\src\pages"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

function Move-IfPresent {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (Test-Path $Source) {
        if (-not (Test-Path $Destination)) {
            Write-Host "Moving $Source -> $Destination"
            Move-Item -Path $Source -Destination $Destination
        }
        else {
            Write-Host "Already exists: $Destination (leaving $Source unchanged)"
        }
    }
}

if (Test-Path ".\scripts\build.ts") {
    if (-not (Test-Path ".\script\build.ts")) {
        Move-Item ".\scripts\build.ts" ".\script\build.ts"
        Write-Host "Fixed scripts/build.ts -> script/build.ts"
    }
}
elseif (Test-Path ".\Scripts\build.ts") {
    if (-not (Test-Path ".\script\build.ts")) {
        Move-Item ".\Scripts\build.ts" ".\script\build.ts"
        Write-Host "Fixed Scripts/build.ts -> script/build.ts"
    }
}

foreach ($oldFolder in @(".\scripts", ".\Scripts")) {
    if (Test-Path $oldFolder) {
        $items = Get-ChildItem $oldFolder -Force
        if ($items.Count -eq 0) {
            Remove-Item $oldFolder -Force
        }
    }
}

Move-IfPresent ".\App.tsx" ".\client\src\App.tsx"
Move-IfPresent ".\main.tsx" ".\client\src\main.tsx"
Move-IfPresent ".\index.css" ".\client\src\index.css"
Move-IfPresent ".\index.html" ".\client\index.html"
Move-IfPresent ".\favicon.png" ".\client\public\favicon.png"
Move-IfPresent ".\app-sidebar.tsx" ".\client\src\components\app-sidebar.tsx"

$uiFiles = @(
    "accordion.tsx",
    "alert-dialog.tsx",
    "alert.tsx",
    "aspect-ratio.tsx",
    "avatar.tsx",
    "badge.tsx",
    "breadcrumb.tsx",
    "button.tsx",
    "calendar.tsx",
    "card.tsx",
    "carousel.tsx",
    "chart.tsx",
    "checkbox.tsx",
    "collapsible.tsx",
    "command.tsx",
    "context-menu.tsx",
    "dialog.tsx",
    "drawer.tsx"
)

foreach ($file in $uiFiles) {
    Move-IfPresent ".\$file" ".\client\src\components\ui\$file"
}

$utilsPath = ".\client\src\lib\utils.ts"
if (-not (Test-Path $utilsPath)) {
@'
import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
'@ | Set-Content -Path $utilsPath -Encoding UTF8

    Write-Host "Created client/src/lib/utils.ts"
}

Write-Host ""
Write-Host "Structure repair finished." -ForegroundColor Green
Write-Host ""
Write-Host "Still NOT created because the original source is missing from GitHub:" -ForegroundColor Yellow
Write-Host "  client/src/components/ui/sidebar.tsx"
Write-Host "  client/src/components/ui/toaster.tsx"
Write-Host "  client/src/components/ui/tooltip.tsx"
Write-Host "  client/src/lib/queryClient.ts"
Write-Host "  client/src/hooks/use-auth.ts"
Write-Host "  client/src/pages/home.tsx"
Write-Host "  client/src/pages/schedule.tsx"
Write-Host "  client/src/pages/dashboard.tsx"
Write-Host "  client/src/pages/progress.tsx"
Write-Host "  client/src/pages/articles.tsx"
Write-Host "  client/src/pages/landing.tsx"
Write-Host "  client/src/pages/not-found.tsx"
Write-Host ""
Write-Host "Open GitHub Desktop now and review the Changes tab."
Write-Host "Suggested commit message: Complete frontend folder structure repair"
