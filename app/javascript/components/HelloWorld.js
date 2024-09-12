const HelloWorld = {
    template: `
    <div>
      <h1>{{ message }}</h1>
    </div>
  `,
    data() {
        return {
            message: 'Hello, Vue!'
        };
    }
}

export default HelloWorld;
