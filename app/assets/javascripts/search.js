// document.addEventListener("turbolinks:load", function() {
//   $input = $("[data-behavior='autocomplete']")

//   var options = {
//     getValue: "name",
//     url: function(phrase) {
//       return "/search.json?q=" + phrase;
//     },
//     categories: [
//       {
//         listLocation: "photos",
//         header: "<strong>Photos</strong>",
//       },
//       {
//         listLocation: "Users",
//         header: "<strong>Users</strong>",
//       }
//     ],
//     list: {
//       onChooseEvent: function() {
//         var url = $input.getSelectedItemData().url
//         $input.val("")
//         Turbolinks.visit(url)
//       }
//     }
//   }

//   $input.easyAutocomplete(options)
// });