//= require_tree ./components

var FactLink = React.createClass({
  loadFactFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: [];
  },
  componentDidMount: function() {
    this.loadFactFromServer();
    setInterval(this.loadScoreFromServer, 5000);
  },
  render: function() {
    return (
      <div>
        <a href={this.props.link} className="fact-boxes">
          <FactTitle />
          <TruthinessScore />
          <PopularityScore />
          <FactCategory />
        </a>
      </div>
    );
  }
});

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
