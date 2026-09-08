local MOD_NAME = "TrueTargetLock"
local SWITCH_TARGET_FUNCTION =
    "/Script/DogwoodCombat.PlayerCombatComponent:SwitchLockTarget"

local function log(message)
    print(string.format("[%s] %s\n", MOD_NAME, message))
end

local hook_ok, pre_hook_id, post_hook_id = pcall(function()
    return RegisterHook(
        SWITCH_TARGET_FUNCTION,
        function(
            _,
            _,
            _,
            _,
            mouse_input,
            _,
            _,
            switch_hard_lock_mouse_input
        )
            local read_ok, is_mouse_input, mouse_can_switch_hard_lock = pcall(
                function()
                    return
                        mouse_input:get(),
                        switch_hard_lock_mouse_input:get()
                end
            )

            if not read_ok then
                return
            end

            if is_mouse_input and mouse_can_switch_hard_lock then
                local write_ok, write_error = pcall(function()
                    switch_hard_lock_mouse_input:set(false)
                end)

                if not write_ok then
                    log("could not suppress mouse target switch: " .. tostring(write_error))
                end
            end
        end,
        function()
        end
    )
end)

if hook_ok then
    log(string.format(
        "loaded (pre=%s, post=%s)",
        tostring(pre_hook_id),
        tostring(post_hook_id)
    ))
else
    log("failed to install target-switch hook: " .. tostring(pre_hook_id))
end
