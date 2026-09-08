local MOD_NAME = "TrueTargetLock"
local SWITCH_TARGET_FUNCTION =
    "/Script/DogwoodCombat.PlayerCombatComponent:SwitchLockTarget"

local function log(message)
    print(string.format("[%s] %s\n", MOD_NAME, message))
end

local function is_hard_locked(context)
    local ok, hard_locked = pcall(function()
        local combat_component = context:get()
        return combat_component.bHardLockOnTarget
    end)

    return ok and hard_locked == true
end

local hook_ok, pre_hook_id, post_hook_id = pcall(function()
    return RegisterHook(
        SWITCH_TARGET_FUNCTION,
        function(
            context,
            _,
            targeting_range,
            user_input,
            mouse_input,
            _,
            _,
            switch_hard_lock_mouse_input
        )
            local read_ok, is_user_input, is_mouse_input,
                mouse_can_switch_hard_lock = pcall(
                function()
                    return
                        user_input:get(),
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

                return
            end

            -- Controller and keyboard target changes use the same function, but
            -- arrive with bMouseInput=false and bSwitchHardLockMouseInput=false.
            -- During an existing hard lock, make the user-requested target search
            -- empty. Initial lock acquisition and automatic target-death handling
            -- remain untouched because those are not hard-locked user switches.
            if is_user_input and not is_mouse_input and is_hard_locked(context) then
                local write_ok, write_error = pcall(function()
                    targeting_range:set(0.0)
                end)

                if not write_ok then
                    log("could not suppress non-mouse target switch: " .. tostring(write_error))
                end
            end
        end,
        function()
        end
    )
end)

if hook_ok then
    log(string.format(
        "loaded with universal input lock (pre=%s, post=%s)",
        tostring(pre_hook_id),
        tostring(post_hook_id)
    ))
else
    log("failed to install target-switch hook: " .. tostring(pre_hook_id))
end
