local GUI = require("GUI")
local system = require("System")

local workspace, window = system.addWindow(GUI.filledWindow(1, 1, 60, 20, 0xE1E1E1))

-- Заголовок окна
window:addChild(GUI.label(1, 1, window.width, 1, 0x2D2D2D, "Клиент Макдональдс")):setAlignment(GUI.ALIGNMENT_HORIZONTAL_CENTER, GUI.ALIGNMENT_VERTICAL_TOP)

-- Текстовое поле для выбора блюд
window:addChild(GUI.label(2, 3, 56, 1, 0x878787, "Выберите блюда (через запятую):"))

-- Поле ввода для выбора блюд
local dishesInput = window:addChild(GUI.input(2, 4, 56, 3, 0xFFFFFF, 0x787878, 0xCCCCCC, 0x2D2D2D, 0xFFFFFF, "", "Например: 1, 3, 5"))

-- Кнопка для отправки заказа
local orderButton = window:addChild(GUI.roundedButton(23, 8, 14, 3, 0xCCCCCC, 0x2D2D2D, 0xAAAAAA, 0x2D2D2D, "Заказать"))

-- Текстовое поле для вывода номера заказа и цены
local orderNumberText = window:addChild(GUI.textBox(2, 12, 56, 6, 0xE1E1E1, 0x2D2D2D, {"Нажмите кнопку для получения номера заказа и цены"}, 1, 0, 0))

workspace:draw()

-- Функция для генерации номера заказа
local function generateOrderNumber()
    return math.random(1000, 9999)
end

-- Функция для вычисления цены заказа
local function calculatePrice(dishes)
    local price = 0
    local selectedDishes = {}
    
    for dish in string.gmatch(dishes, "%d") do
        dish = tonumber(dish)
        if dish == "бургер" or dish == "бургер" or dish == "бургер" then
            table.insert(selectedDishes, dish)
        end
    end
    
    if #selectedDishes == 3 and table.concat(selectedDishes, ",") == "бургер,картошка,хуй" then
        price = 1200
    else
        for _, dish in ipairs(selectedDishes) do
            if dish == "бургер" then
                price = price + 40
            elseif dish == "бургер" then
                price = price + 500
            elseif dish == "бургер" then
                price = price + 400
            end
        end
    end
    
    return price
end

-- Обработчик нажатия кнопки
orderButton.onTouch = function()
    local dishes = dishesInput.text
    if dishes == "" then
        GUI.alert("Пожалуйста, выберите хотя бы одно блюдо")
    else
        local orderNumber = generateOrderNumber()
        local price = calculatePrice(dishes)
        orderNumberText.lines = { "Ваш номер заказа:", tostring(orderNumber), "Общая стоимость:", tostring(price) .. " руб." }
        workspace:draw()
    end
end

workspace:draw()
