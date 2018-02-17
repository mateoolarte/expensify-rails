const filters = {
  month: "",
  options: "",
  category: ""
}

const filterEvent = (class_filter, data_attr) => {
  $(document).on("click", class_filter, function (e) {
    e.preventDefault()

    $(this).siblings().removeClass("active")
    $(this).toggleClass("active")

    const value = $(this).data(data_attr).toString()

    switch (data_attr) {
      case "month":
        if (value == filters.month) {
          filters.month = ""
        } else {
          filters.month = value
        }
        break;
      case "options":
        if (value == filters.options) {
          filters.options = ""
        } else {
          filters.options = value
        }
        break;
      case "category":
        if (value == filters.category) {
          filters.category = ""
        } else {
          filters.category = value
        }
        break;
    }

    const dataParams = {}

    filters.month !== "" ? dataParams.month_ago = filters.month : ""
    filters.options !== "" ? dataParams.type = filters.options : ""
    filters.category !== "" ? dataParams.category = filters.category : ""

    $.ajax({
      url: "/expenses",
      type: "GET",
      dataType: 'script',
      cache: true,
      data: dataParams,
    })
  })
}

filterEvent(".filter-option", "options")
filterEvent(".filter-category", "category")
filterEvent(".filter-month", "month")