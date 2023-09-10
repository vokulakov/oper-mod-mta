local restMoney = {}

-- Количество денег за 100000 очков дрифта
local drift_money = 250

addEvent("dpDriftPoints.earnedPoints", true)
addEventHandler("dpDriftPoints.earnedPoints", resourceRoot, function (points)
    local driftMoney = drift_money

	local money = points / 100000 * driftMoney


    if not restMoney[client] then
        restMoney[client] = 0
    end

    restMoney[client] = restMoney[client] + (money - math.floor(money))

    if restMoney[client] >= 1 then
        money = money + 1
        restMoney[client] = restMoney[client] - 1
    end

    givePlayerMoney(client, math.floor(money))
    --exports.dpCore:givePlayerMoney(client, math.floor(money))
end)

addEventHandler("onPlayerQuit", root,
    function ()
        if restMoney[source] then
            restMoney[source] = nil
        end
    end
)