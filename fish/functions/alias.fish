function code --wraps='flatpak run com.visualstudio.code' --description 'alias code=flatpak run com.visualstudio.code'
    flatpak run com.visualstudio.code $argv
end

function zed --wraps='flatpak run dev.zed.Zed' --description 'alias zed=flatpak run dev.zed.Zed'
    flatpak run dev.zed.Zed $argv
end

function q --wraps=exit --description 'alias q=exit'
    exit $argv
end
