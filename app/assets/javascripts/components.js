//= require_tree ./components
//= fact_link

// var FriendBox = React.createClass({
//   loadFactFromServer: function() {
//     $.ajax({
//       url: this.props.url,
//       dataType: 'json',
//       cache: false,
//       success: function(data) {
//         this.setState({data: data});
//       }.bind(this),
//       error: function(xhr, status, err) {
//         console.error(this.props.url, status, err.toString());
//       }.bind(this)
//     });
//   },
//
//   onFriendChange: function(formData) {
//     this.loadFriendsFromServer(formData);
//   },
//
//   getInitialState: function() {
//     return { data: [] };
//   },
//
//   componentDidMount: function() {
//     this.loadFriendsFromServer({});
//   },
//
//   render: function() {
//     return (
//       <div className="friendBox">
//         <h1>Friend Finder</h1>
//         <FriendForm onFriendChange={this.onFriendChange} />
//         <FriendList data={this.state.data} />
//       </div>
//     );
//   }
// });
