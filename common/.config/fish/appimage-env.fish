# AppImages (Solo) export vars pointing into their /tmp/.mount_* dir; children
# inherit them and break system python/git. Drop entries under $APPDIR.
if set -q APPDIR
    set -l appdir $APPDIR
    for var in (set -xn)
        set -l orig (string join : -- $$var)
        set -l kept (string split : -- $orig | string match -v -- "$appdir*" | string match -v '')
        test "$orig" = "$(string join : -- $kept)"; and continue
        if set -q kept[1]
            set -gx $var (string join : -- $kept)
        else
            set -e $var
        end
    end
    set -e APPDIR APPIMAGE ARGV0 OWD
end
