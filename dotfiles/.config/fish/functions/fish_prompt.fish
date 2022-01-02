function fish_prompt
    set_color green;
    echo -n (prompt_pwd);
    set_color white;
    echo -n (fish_vcs_prompt);
    set_color reset;
    echo -n '> ';
end
