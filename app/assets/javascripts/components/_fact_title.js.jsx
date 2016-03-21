var FactTitle = React.createClass({
  loadScoreFromServer: function() {
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
    return {data: {title: this.props.title}};
  },
  componentDidMount: function() {
    this.loadScoreFromServer();
    setInterval(this.loadScoreFromServer, this.props.pollInterval);
  },
  shouldComponentUpdate: function(nextProps, nextState) {
    return nextState.data.title !== this.state.data.title;
  },
  render: function() {
    return (
      <div>
        <p className="fact-name">
          <strong>
            {this.state.data.title}
          </strong>
        </p>
      </div>
    );
  }
});
