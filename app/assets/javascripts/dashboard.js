function LoadMetrics() {
  /* Toggle Data in Chart */
  const toggleDataSeries = function (e) {
    if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
      e.dataSeries.visible = false
    } else {
      e.dataSeries.visible = true
    }
  }

  const toggleDataSeriesSixChart = function (e) {
    toggleDataSeries(e)
    chartSixMonths.render()
  }

  const toggleDataSeriesOneChart = function (e) {
    toggleDataSeries(e)
    chartPerDay.render()
  }
  /* Toggle Data in Chart */

  /* Show Data amount in Chart */
  const toolTipContent = function (e) {
    let str = ""
    let total = 0
    let str2, str3
    for (var i = 0; i < e.entries.length; i++) {
      let str1 = "<span style= \"color:" + e.entries[i].dataSeries.color + "\"> " + e.entries[i].dataSeries.name + "</span>: $<strong>" + e.entries[i].dataPoint.y + "</strong><br/>"
      total = e.entries[i].dataPoint.y + total;
      str = str.concat(str1)
    }
    str2 = "<span style = \"color:DodgerBlue;\"><strong>" + (e.entries[0].dataPoint.x).getFullYear() + "</strong></span><br/>"
    total = Math.round(total * 100) / 100;
    str3 = "<span style = \"color:Tomato\">Total:</span><strong> $" + total + "</strong><br/>";
    return (str2.concat(str)).concat(str3)
  }
  /* Show Data amount in Chart */

  const expensesSixMonths = $("#expenses-chart").data("expenses")
  let dataSixMonths = []

  const expensesCategories = $("#category-chart").data("categories")
  let dataPerCategories = []

  const expensesOneMonth = expensesSixMonths.filter(expense => expense.date >= moment().startOf('month').format("YYYY-MM-DD") && expense.date <= moment().format("YYYY-MM-DD"))
  let dataPresentMonth = []

  let dataTotalMonth = []

  let totalToday = 0
  let totalYesterday = 0
  let totalPresentMonth = 0
  let totalPreviousMonth = 0

  const today = moment().format("YYYY-MM-DD")
  const yesterday = moment().subtract(1, 'days').format("YYYY-MM-DD")
  const startpreviousMonth = moment().startOf('month').subtract(1, 'month').format("YYYY-MM-DD")
  const endPreviousMonth = moment().endOf('month').subtract(1, 'month').format("YYYY-MM-DD")

  const expensesToday = expensesOneMonth.filter(expense => expense.date == today)
  const expensesYesterday = expensesOneMonth.filter(expense => expense.date == yesterday)
  const expensesPresentMonth = expensesOneMonth
  const expensesPreviousMonth = expensesSixMonths.filter(expense => expense.date >= startpreviousMonth && expense.date <= endPreviousMonth)

  expensesToday.forEach((value, index) => totalToday += parseFloat(value.amount))
  expensesYesterday.forEach((value, index) => totalYesterday += parseFloat(value.amount))
  expensesPresentMonth.forEach((value, index) => totalPresentMonth += parseFloat(value.amount))
  expensesPreviousMonth.forEach((value, index) => totalPreviousMonth += parseFloat(value.amount))

  $(".totaltoday").prepend(`$${totalToday.toLocaleString()}`)
  $(".totalyesterday").prepend(`$${totalYesterday.toLocaleString()}`)
  $(".totalpresentmonth").prepend(`$${totalPresentMonth.toLocaleString()}`)
  $(".totalpreviousmonth").prepend(`$${totalPreviousMonth.toLocaleString()}`)

  const buildDataMonths = (name, data_months) => {
    let dataValues = []
    data_months === "Six months" ? data_months = expensesSixMonths : data_months = expensesOneMonth

    const expenseTypeName = data_months.filter(expense => expense.options == name)

    expenseTypeName.forEach((value, index) => {
      const year = moment(value.date, "YYYY-MM-DD").year()
      const month = moment(value.date, "YYYY-MM-DD").month()
      const day = moment(value.date, "YYYY-MM-DD").date()
      const amount = parseFloat(value.amount)

      dataValues.push({
        x: data_months == expensesSixMonths ? new Date(year, month) : day,
        y: amount
      })
    })

    const dataType = {
      type: data_months == expensesSixMonths ? "stackedColumn" : "column",
      showInLegend: true,
      color: name == "Compra" ? "#1e88e5" : name == "Retiro" ? "#e53935" : name == "Transferencia" ? "#8e24aa" : "#43a047",
      name: name,
      dataPoints: dataValues
    }

    return dataType
  }

  const purchasesSix = buildDataMonths("Compra", "Six months")
  const withdrawalsSix = buildDataMonths("Retiro", "Six months")
  const transfersSix = buildDataMonths("Transferencia", "Six months")
  const paymentsSix = buildDataMonths("Pago", "Six months")

  dataSixMonths.push(purchasesSix, withdrawalsSix, transfersSix, paymentsSix)

  const purchasesOne = buildDataMonths("Compra")
  const withdrawalsOne = buildDataMonths("Retiro")
  const transfersOne = buildDataMonths("Transferencia")
  const paymentsOne = buildDataMonths("Pago")

  dataPresentMonth.push(purchasesOne, withdrawalsOne, transfersOne, paymentsOne)

  const buildCategoriesPerMonth = (category) => {
    let totalAmount = 0

    const expenseTypeCategory = expensesOneMonth.filter(expense => expense.category_id == category)

    expenseTypeCategory.forEach((value, index) => totalAmount += parseFloat(value.amount))

    let modelCategory = category = category - 1

    const dataValues = {
      y: totalAmount,
      label: expensesCategories[modelCategory].name
    }

    return dataValues
  }

  const categoryRestaurant = buildCategoriesPerMonth(1)
  const categoryFood = buildCategoriesPerMonth(2)
  const categoryCar = buildCategoriesPerMonth(3)
  const categoryServices = buildCategoriesPerMonth(4)
  const categoryHome = buildCategoriesPerMonth(5)
  const categoryEducation = buildCategoriesPerMonth(6)
  const categoryFun = buildCategoriesPerMonth(7)
  const categoryTravel = buildCategoriesPerMonth(8)

  dataPerCategories.push(categoryRestaurant, categoryFood, categoryCar, categoryServices, categoryHome, categoryEducation, categoryFun, categoryTravel)

  const buildDataSumMonth = (name, data) => {
    let dataValues = []
    let totalAmount = 0

    const compare = (a, b) => {
      // Use toUpperCase() to ignore character casing
      const dateA = a.date.toUpperCase()
      const dateB = b.date.toUpperCase()

      let comparison = 0

      if (dateA > dateB) {
        comparison = 1
      } else if (dateA < dateB) {
        comparison = -1
      }

      return comparison
    }

    const removeUndefined = (array, element) => array.filter(e => e !== element)

    data.sort(compare).forEach((value, index) => {
      const day = moment(value.date, "YYYY-MM-DD").date()
      const amount = parseFloat(value.amount)

      if (dataValues[day] == day) {
        dataValues[day].y = totalAmount + amount
      } else {
        dataValues[day] = {
          x: day,
          y: totalAmount += amount
        }
      }
    })

    dataValues = removeUndefined(dataValues, undefined)

    const dataType = {
      type: "area",
      showInLegend: true,
      toolTipContent: `<span style="color:${name == "Mes actual" ? "#e53935" : "#1e88e5"}"><strong>{name}: </strong></span> {y}`,
      color: name == "Mes actual" ? "#e53935" : "#1e88e5",
      name: name,
      markerSize: 0,
      dataPoints: dataValues
    }

    return dataType
  }

  const sumPresentMonth = buildDataSumMonth("Mes actual", expensesPresentMonth)
  const sumPreviousMonth = buildDataSumMonth("Mes anterior", expensesPreviousMonth)

  dataTotalMonth.push(sumPreviousMonth, sumPresentMonth)

  const chartSixMonths = new CanvasJS.Chart("expenses-chart", {
    theme: "dark2",
    animationEnabled: true,
    axisX: {
      interval: 1,
      intervalType: "month"
    },
    toolTip: {
      shared: true,
      content: toolTipContent
    },
    legend: {
      cursor: "pointer",
      itemclick: toggleDataSeriesSixChart
    },
    data: dataSixMonths
  })

  const chartPerDay = new CanvasJS.Chart("daily-expenses-chart", {
    theme: "dark2",
    animationEnabled: true,
    axisX: {
      interval: 1,
      intervalType: "day"
    },
    legend: {
      cursor: "pointer",
      itemclick: toggleDataSeriesOneChart
    },
    data: dataPresentMonth
  })

  const chartPerCategory = new CanvasJS.Chart("category-chart", {
    theme: "dark2",
    animationEnabled: true,
    data: [{
      type: "doughnut",
      startAngle: 50,
      indexLabelFontSize: 10,
      indexLabel: "{label}",
      toolTipContent: "<b>{label}:</b> {y} (#percent%)",
      dataPoints: dataPerCategories
    }]
  })

  const chartTotalMonth = new CanvasJS.Chart("month-acc", {
    theme: "dark2",
    animationEnabled: true,
    toolTip: {
      shared: true
    },
    axisX: {
      interval: 1,
      intervalType: "day"
    },
    data: dataTotalMonth
  })

  chartSixMonths.render()
  chartPerDay.render()
  chartPerCategory.render()
  chartTotalMonth.render()
}