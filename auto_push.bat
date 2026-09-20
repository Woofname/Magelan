@echo off
chcp 65001 >nul
echo 正在檢查更新並推送到 GitHub...

:: 確保在當前目錄執行
cd /d "%~dp0"

:: 檢查是否有檔案異動
git status -s >nul 2>&1
if errorlevel 1 (
    echo [錯誤] 這裡不是 Git 儲存庫，請確認檔案放置路徑。
    goto END
)

:: 抓取目前的日期時間作為 Commit 說明
set CURRENT_TIME=%date:~0,10% %time:~0,8%

echo 1. 加入異動檔案 (git add)
git add .

echo 2. 建立提交 (git commit)
git commit -m "Auto update: %CURRENT_TIME%"

echo 3. 推送到 GitHub (git push)
git push origin main

if errorlevel 0 (
    echo.
    echo ===================================
    echo [成功] 檔案已順利推送到 GitHub！
    echo ===================================
) else (
    echo.
    echo ===================================
    echo [失敗] 推送失敗，請檢查網路或衝突狀態。
    echo ===================================
)

:END
echo.
pause